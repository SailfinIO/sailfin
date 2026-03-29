/*
 * sailfin_base64.h — Base64 encode/decode for Sailfin runtime.
 * No external dependencies.
 */
#ifndef SAILFIN_BASE64_H
#define SAILFIN_BASE64_H

#include <stdint.h>
#include <stddef.h>

/*
 * Encode `length` bytes of `data` to base64.
 * Returns a malloc'd null-terminated string (no line wrapping).
 */
char *sailfin_runtime_base64_encode(const char *data, int64_t length);

/*
 * Decode a null-terminated base64 string.
 * Returns malloc'd bytes; writes decoded byte count to *out_length.
 * Returns NULL on invalid input.
 */
char *sailfin_runtime_base64_decode(const char *b64, int64_t *out_length);

#endif /* SAILFIN_BASE64_H */
