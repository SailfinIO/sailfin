/*
 * sailfin_sha256.h — Standalone FIPS 180-4 SHA-256 for Sailfin runtime.
 * No external dependencies.
 */
#ifndef SAILFIN_SHA256_H
#define SAILFIN_SHA256_H

#include <stdint.h>
#include <stddef.h>

/* Low-level API */
typedef struct {
    uint32_t state[8];
    uint64_t bitcount;
    uint8_t  buffer[64];
} SailfinSha256Ctx;

void sailfin_sha256_init(SailfinSha256Ctx *ctx);
void sailfin_sha256_update(SailfinSha256Ctx *ctx, const uint8_t *data, size_t len);
void sailfin_sha256_final(SailfinSha256Ctx *ctx, uint8_t digest[32]);

/*
 * High-level API exposed to Sailfin code.
 * Returns a malloc'd string "sha256:<64 hex chars>".
 */
char *sailfin_runtime_sha256_hex(const char *data, int64_t length);

#endif /* SAILFIN_SHA256_H */
