/**
 * @fileoverview
 * Enumeration of supported cryptographic algorithms.
 * This module defines the `Algorithm` enum, which lists various algorithms
 * used for signing, hashing, and encryption in JSON Web Tokens (JWT),
 * JSON Web Keys (JWK), and other cryptographic operations.
 *
 * @module src/enums/Algorithm
 */

/**
 * Represents the supported cryptographic algorithms.
 *
 * The `Algorithm` enum includes various algorithms used for signing JWTs,
 * hashing data, and performing encryption/decryption operations. Each member
 * corresponds to a standardized algorithm identifier.
 *
 * @enum {string}
 */
export enum Algorithm {
  /**
   * RSASSA-PKCS1-v1_5 using SHA-256.
   *
   * @member {string} Algorithm.RS256
   */
  RS256 = 'RS256',

  /**
   * HMAC using SHA-256.
   *
   * @member {string} Algorithm.HS256
   */
  HS256 = 'HS256',

  /**
   * ECDSA using P-256 and SHA-256.
   *
   * @member {string} Algorithm.ES256
   */
  ES256 = 'ES256',

  /**
   * RSASSA-PSS using SHA-256 and MGF1 with SHA-256.
   *
   * @member {string} Algorithm.PS256
   */
  PS256 = 'PS256',

  /**
   * RSASSA-PKCS1-v1_5 using SHA-384.
   *
   * @member {string} Algorithm.RS384
   */
  RS384 = 'RS384',

  /**
   * HMAC using SHA-384.
   *
   * @member {string} Algorithm.HS384
   */
  HS384 = 'HS384',

  /**
   * ECDSA using P-384 and SHA-384.
   *
   * @member {string} Algorithm.ES384
   */
  ES384 = 'ES384',

  /**
   * RSASSA-PSS using SHA-384 and MGF1 with SHA-384.
   *
   * @member {string} Algorithm.PS384
   */
  PS384 = 'PS384',

  /**
   * RSASSA-PKCS1-v1_5 using SHA-512.
   *
   * @member {string} Algorithm.RS512
   */
  RS512 = 'RS512',

  /**
   * HMAC using SHA-512.
   *
   * @member {string} Algorithm.HS512
   */
  HS512 = 'HS512',

  /**
   * ECDSA using P-521 and SHA-512.
   *
   * @member {string} Algorithm.ES512
   */
  ES512 = 'ES512',

  /**
   * RSASSA-PSS using SHA-512 and MGF1 with SHA-512.
   *
   * @member {string} Algorithm.PS512
   */
  PS512 = 'PS512',

  /**
   * Secure Hash Algorithm 1 (SHA-1).
   *
   * @member {string} Algorithm.SHA1
   */
  SHA1 = 'SHA1',

  /**
   * Secure Hash Algorithm 2 with 256-bit hash (SHA-256).
   *
   * @member {string} Algorithm.SHA256
   */
  SHA256 = 'SHA256',

  /**
   * Secure Hash Algorithm 2 with 384-bit hash (SHA-384).
   *
   * @member {string} Algorithm.SHA384
   */
  SHA384 = 'SHA384',

  /**
   * Secure Hash Algorithm 2 with 512-bit hash (SHA-512).
   *
   * @member {string} Algorithm.SHA512
   */
  SHA512 = 'SHA512',

  MD5 = 'MD5',

  EC_PUBLIC_KEY = 'EC_PUBLIC_KEY',

  RSA_PUBLIC_KEY = 'RSA_PUBLIC_KEY',
}
