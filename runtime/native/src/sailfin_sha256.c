/*
 * sailfin_sha256.c — Standalone FIPS 180-4 SHA-256 implementation.
 *
 * Based on the public domain implementation by Brad Conte
 * (brad AT bradconte.com). Adapted for Sailfin runtime conventions.
 */

#include "sailfin_sha256.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

/* ---------- constants ---------- */

static const uint32_t K[64] = {
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
    0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
    0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
    0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
    0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
    0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
};

/* ---------- helpers ---------- */

#define ROTR(x, n)  (((x) >> (n)) | ((x) << (32 - (n))))
#define CH(x, y, z)  (((x) & (y)) ^ (~(x) & (z)))
#define MAJ(x, y, z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
#define EP0(x)  (ROTR(x, 2)  ^ ROTR(x, 13) ^ ROTR(x, 22))
#define EP1(x)  (ROTR(x, 6)  ^ ROTR(x, 11) ^ ROTR(x, 25))
#define SIG0(x) (ROTR(x, 7)  ^ ROTR(x, 18) ^ ((x) >> 3))
#define SIG1(x) (ROTR(x, 17) ^ ROTR(x, 19) ^ ((x) >> 10))

/* ---------- transform one 64-byte block ---------- */

static void _sha256_transform(SailfinSha256Ctx *ctx, const uint8_t block[64])
{
    uint32_t W[64];
    uint32_t a, b, c, d, e, f, g, h, t1, t2;
    int i;

    for (i = 0; i < 16; i++) {
        W[i] = ((uint32_t)block[i * 4    ] << 24)
             | ((uint32_t)block[i * 4 + 1] << 16)
             | ((uint32_t)block[i * 4 + 2] <<  8)
             | ((uint32_t)block[i * 4 + 3]);
    }
    for (i = 16; i < 64; i++) {
        W[i] = SIG1(W[i - 2]) + W[i - 7] + SIG0(W[i - 15]) + W[i - 16];
    }

    a = ctx->state[0]; b = ctx->state[1];
    c = ctx->state[2]; d = ctx->state[3];
    e = ctx->state[4]; f = ctx->state[5];
    g = ctx->state[6]; h = ctx->state[7];

    for (i = 0; i < 64; i++) {
        t1 = h + EP1(e) + CH(e, f, g) + K[i] + W[i];
        t2 = EP0(a) + MAJ(a, b, c);
        h = g; g = f; f = e; e = d + t1;
        d = c; c = b; b = a; a = t1 + t2;
    }

    ctx->state[0] += a; ctx->state[1] += b;
    ctx->state[2] += c; ctx->state[3] += d;
    ctx->state[4] += e; ctx->state[5] += f;
    ctx->state[6] += g; ctx->state[7] += h;
}

/* ---------- public API ---------- */

void sailfin_sha256_init(SailfinSha256Ctx *ctx)
{
    ctx->bitcount = 0;
    ctx->state[0] = 0x6a09e667; ctx->state[1] = 0xbb67ae85;
    ctx->state[2] = 0x3c6ef372; ctx->state[3] = 0xa54ff53a;
    ctx->state[4] = 0x510e527f; ctx->state[5] = 0x9b05688c;
    ctx->state[6] = 0x1f83d9ab; ctx->state[7] = 0x5be0cd19;
}

void sailfin_sha256_update(SailfinSha256Ctx *ctx, const uint8_t *data, size_t len)
{
    size_t i;
    size_t buf_idx = (size_t)((ctx->bitcount >> 3) & 0x3F);

    ctx->bitcount += (uint64_t)len << 3;

    for (i = 0; i < len; i++) {
        ctx->buffer[buf_idx++] = data[i];
        if (buf_idx == 64) {
            _sha256_transform(ctx, ctx->buffer);
            buf_idx = 0;
        }
    }
}

void sailfin_sha256_final(SailfinSha256Ctx *ctx, uint8_t digest[32])
{
    size_t buf_idx = (size_t)((ctx->bitcount >> 3) & 0x3F);
    int i;

    ctx->buffer[buf_idx++] = 0x80;

    if (buf_idx > 56) {
        while (buf_idx < 64)
            ctx->buffer[buf_idx++] = 0;
        _sha256_transform(ctx, ctx->buffer);
        buf_idx = 0;
    }

    while (buf_idx < 56)
        ctx->buffer[buf_idx++] = 0;

    /* Append bit length in big-endian */
    for (i = 7; i >= 0; i--)
        ctx->buffer[buf_idx++] = (uint8_t)(ctx->bitcount >> (i * 8));

    _sha256_transform(ctx, ctx->buffer);

    for (i = 0; i < 8; i++) {
        digest[i * 4    ] = (uint8_t)(ctx->state[i] >> 24);
        digest[i * 4 + 1] = (uint8_t)(ctx->state[i] >> 16);
        digest[i * 4 + 2] = (uint8_t)(ctx->state[i] >>  8);
        digest[i * 4 + 3] = (uint8_t)(ctx->state[i]);
    }
}

/* ---------- high-level helper for Sailfin runtime ---------- */

static const char _hex_chars[] = "0123456789abcdef";

char *sailfin_runtime_sha256_hex(const char *data, int64_t length)
{
    if (!data || length < 0)
        return NULL;

    SailfinSha256Ctx ctx;
    uint8_t digest[32];

    sailfin_sha256_init(&ctx);
    sailfin_sha256_update(&ctx, (const uint8_t *)data, (size_t)length);
    sailfin_sha256_final(&ctx, digest);

    /* "sha256:" (7) + 64 hex chars + '\0' = 72 bytes */
    char *out = (char *)malloc(72);
    if (!out)
        return NULL;

    memcpy(out, "sha256:", 7);
    for (int i = 0; i < 32; i++) {
        out[7 + i * 2]     = _hex_chars[(digest[i] >> 4) & 0x0F];
        out[7 + i * 2 + 1] = _hex_chars[digest[i] & 0x0F];
    }
    out[71] = '\0';

    return out;
}
