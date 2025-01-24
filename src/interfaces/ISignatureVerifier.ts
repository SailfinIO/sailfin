/**
 * @fileoverview
 * Defines the `ISignatureVerifier` interface for verifying JWT signatures.
 * This interface provides a contract for implementing signature verification
 * logic using public keys fetched from a JWKS (JSON Web Key Set) endpoint.
 *
 * @module src/interfaces/ISignatureVerifier
 */

import { JwtHeader } from './Jwt';

/**
 * Defines the `ISignatureVerifier` interface for verifying JWT signatures.
 *
 * The `ISignatureVerifier` interface provides methods for verifying the signature
 * of a JWT using public keys retrieved from a JWKS endpoint. It supports multiple
 * key types and algorithms, ensuring the integrity and authenticity of JWTs.
 */
export interface ISignatureVerifier {
  /**
   * Verifies the signature of a JWT.
   *
   * This method validates the signature of the provided JWT using the public key
   * associated with the Key ID (`kid`) specified in the JWT header. It ensures that
   * the signature is valid and that the JWT has not been tampered with.
   *
   * @param {JwtHeader} header - The JWT header containing algorithm (`alg`) and Key ID (`kid`).
   * @param {string} idToken - The JWT string to verify.
   * @returns {Promise<void>} Resolves if the signature is valid; otherwise, throws an error.
   *
   * @throws {ClientError} If the signature is invalid, the key type is unsupported, or verification fails.
   *
   * @example
   * ```typescript
   * const signatureVerifier: ISignatureVerifier = new SignatureVerifier(jwksClient);
   * try {
   *   await signatureVerifier.verify(jwtHeader, idToken);
   *   console.log('JWT signature is valid.');
   * } catch (error) {
   *   console.error('JWT signature verification failed:', error);
   * }
   * ```
   */
  verify(header: JwtHeader, idToken: string): Promise<void>;
}
