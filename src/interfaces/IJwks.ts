/**
 * @fileoverview
 * Defines the `IJwks` interface for managing JSON Web Keys (JWKs).
 * This interface provides a contract for implementing JWKS operations,
 * including fetching keys by Key ID (kid) and refreshing the JWKS cache.
 *
 * @module src/interfaces/IJwks
 */

import { Jwk } from './Jwk';

/**
 * Represents a JSON Web Key Set (JWKS) response.
 *
 * The `JwksResponse` interface defines the structure of a JWKS response,
 * which contains an array of JSON Web Keys (JWK). JWKS is commonly used
 * in OAuth 2.0 and OpenID Connect to represent a set of keys that can be
 * used to verify the signatures of tokens.
 *
 * @interface JwksResponse
 */
export interface JwksResponse {
  /**
   * An array of JSON Web Keys.
   *
   * @type {Jwk[]}
   * @example [{ kty: 'RSA', kid: 'key-id-123', ... }]
   */
  keys: Jwk[];
}

/**
 * Defines the `IJwks` interface for managing and retrieving JSON Web Keys (JWKs).
 *
 * The `IJwks` interface provides methods for fetching JWKs from a JWKS URI,
 * retrieving specific keys by their Key ID (kid), and refreshing the JWKS cache.
 * Implementations of this interface can utilize various caching mechanisms to
 * optimize key retrieval and reduce network requests.
 */
export interface IJwks {
  /**
   * Retrieves a JSON Web Key (JWK) by its Key ID (kid).
   *
   * This method first attempts to retrieve the JWK from the cache. If the key is not
   * found or the cache is empty, it refreshes the cache by fetching the JWKS from the URI.
   *
   * @param {string} kid - The Key ID to search for.
   * @returns {Promise<Jwk>} The corresponding JWK.
   *
   * @throws {ClientError} If the `kid` is invalid or the key is not found.
   *
   * @example
   * ```typescript
   * const jwk = await jwksClient.getKey('myKid');
   * console.log(jwk);
   * ```
   */
  getKey(kid: string): Promise<Jwk>;

  /**
   * Refreshes the JWKS cache by fetching the latest keys from the JWKS URI.
   *
   * This method fetches the JWKS from the configured URI, validates its structure,
   * and stores it in the cache with the specified Time-To-Live (TTL).
   *
   * @returns {Promise<void>} Resolves when the cache has been successfully refreshed.
   *
   * @throws {ClientError} If fetching or parsing the JWKS fails.
   *
   * @example
   * ```typescript
   * await jwksClient.refreshCache();
   * console.log('JWKS cache has been refreshed.');
   * ```
   */
  refreshCache(): Promise<void>;
}
