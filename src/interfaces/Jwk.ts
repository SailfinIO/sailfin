/**
 * @fileoverview
 * Defines interfaces for JSON Web Keys (JWK) and JSON Web Key Sets (JWKS).
 * This module provides TypeScript interfaces that represent the structure
 * of JWKs and JWKS responses as defined in RFC 7517. These interfaces are
 * used for type-checking and ensuring the correctness of key-related data
 * within the application.
 *
 * @module src/interfaces/Jwk
 */

/**
 * Represents a JSON Web Key (JWK).
 *
 * The `Jwk` interface defines the structure of a single JWK, which is a JSON
 * data structure that represents a cryptographic key. JWKs are used in various
 * web security standards, including JWT (JSON Web Tokens) and OAuth 2.0.
 *
 * @interface Jwk
 */
export interface Jwk {
  /**
   * The key type (`kty`) parameter identifies the cryptographic algorithm family used with the key.
   * For example, "RSA" or "EC".
   *
   * @type {string}
   * @required
   */
  kty: string;

  /**
   * The intended use (`use`) parameter identifies the intended use of the public key.
   * For example, "sig" for signature or "enc" for encryption.
   *
   * @type {string}
   * @optional
   */
  use?: string;

  /**
   * The key operations (`key_ops`) parameter identifies the operations for which the key is intended.
   * This parameter is a JSON array of key operation values.
   *
   * @type {string[]}
   * @optional
   */
  key_ops?: string[];

  /**
   * The algorithm (`alg`) parameter identifies the algorithm intended for use with the key.
   *
   * @type {string}
   * @optional
   */
  alg?: string;

  /**
   * The key ID (`kid`) parameter is used to match a specific key.
   * It is a hint indicating which key was used to secure the JWK.
   *
   * @type {string}
   * @optional
   */
  kid?: string;

  /**
   * The X.509 URL (`x5u`) parameter is a URI that refers to a resource for an X.509 public key certificate or certificate chain.
   *
   * @type {string}
   * @optional
   */
  x5u?: string;

  /**
   * The X.509 certificate chain (`x5c`) parameter is a chain of one or more PKIX certificates.
   * The certificate containing the public key MUST be first.
   *
   * @type {string[]}
   * @optional
   */
  x5c?: string[];

  /**
   * The X.509 certificate SHA-1 thumbprint (`x5t`) parameter is a base64url-encoded SHA-1 thumbprint of the DER encoding of an X.509 certificate.
   *
   * @type {string}
   * @optional
   */
  x5t?: string;

  /**
   * The X.509 certificate SHA-256 thumbprint (`x5t#S256`) parameter is a base64url-encoded SHA-256 thumbprint of the DER encoding of an X.509 certificate.
   *
   * @type {string}
   * @optional
   */
  x5t_S256?: string;

  /**
   * The modulus (`n`) parameter for RSA keys, which is the RSA modulus.
   * It is a base64url-encoded value representing the modulus for the RSA key.
   *
   * @type {string}
   * @optional
   */
  n?: string;

  /**
   * The exponent (`e`) parameter for RSA keys, which is the RSA public exponent.
   * It is a base64url-encoded value representing the exponent for the RSA key.
   *
   * @type {string}
   * @optional
   */
  e?: string;

  /**
   * The private exponent (`d`) parameter for RSA private keys.
   * It is a base64url-encoded value representing the private exponent.
   *
   * @type {string}
   * @optional
   */
  d?: string;

  /**
   * The first prime factor (`p`) for RSA private keys.
   * It is a base64url-encoded value representing the first prime factor.
   *
   * @type {string}
   * @optional
   */
  p?: string;

  /**
   * The second prime factor (`q`) for RSA private keys.
   * It is a base64url-encoded value representing the second prime factor.
   *
   * @type {string}
   * @optional
   */
  q?: string;

  /**
   * The first factor CRT exponent (`dp`) for RSA private keys.
   * It is a base64url-encoded value representing the first factor CRT exponent.
   *
   * @type {string}
   * @optional
   */
  dp?: string;

  /**
   * The second factor CRT exponent (`dq`) for RSA private keys.
   * It is a base64url-encoded value representing the second factor CRT exponent.
   *
   * @type {string}
   * @optional
   */
  dq?: string;

  /**
   * The first CRT coefficient (`qi`) for RSA private keys.
   * It is a base64url-encoded value representing the first CRT coefficient.
   *
   * @type {string}
   * @optional
   */
  qi?: string;

  /**
   * The other primes (`oth`) parameter for multi-prime RSA keys.
   * It is a JSON array of objects, each containing the other prime's `r`, `d`, and `t` values.
   *
   * @type {Array<{ r: string; d: string; t: string }>}
   * @optional
   */
  oth?: Array<{ r: string; d: string; t: string }>;

  /**
   * The curve (`crv`) parameter for Elliptic Curve (EC) keys, which identifies the curve used.
   * For example, "P-256", "P-384", or "P-521".
   *
   * @type {string}
   * @optional
   */
  crv?: string;

  /**
   * The x-coordinate (`x`) parameter for EC public keys.
   * It is a base64url-encoded value representing the x-coordinate of the EC point.
   *
   * @type {string}
   * @optional
   */
  x?: string;

  /**
   * The y-coordinate (`y`) parameter for EC public keys.
   * It is a base64url-encoded value representing the y-coordinate of the EC point.
   *
   * @type {string}
   * @optional
   */
  y?: string;
}
