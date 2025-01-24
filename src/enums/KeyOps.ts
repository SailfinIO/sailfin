// src/enums/KeyOps.ts

/**
 * Supported key operations for JWK usage.
 */
export enum KeyOps {
  SIGN = 'sign',
  VERIFY = 'verify',
  ENCRYPT = 'encrypt',
  DECRYPT = 'decrypt',
  WRAP_KEY = 'wrapKey',
  UNWRAP_KEY = 'unwrapKey',
  DERIVE_KEY = 'deriveKey',
  DERIVE_BITS = 'deriveBits',
}
