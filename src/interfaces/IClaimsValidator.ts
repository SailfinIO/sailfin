/**
 * @fileoverview
 * Defines the `IClaimsValidator` interface for validating JWT claims.
 * This interface provides a contract for implementing validation logic
 * for critical JWT claims such as issuer, audience, expiration, and nonce.
 *
 * @module src/interfaces/IClaimsValidator
 */

import { JwtPayload } from './Jwt';

/**
 * Defines the `IClaimsValidator` interface for validating claims in a JWT payload.
 *
 * The `IClaimsValidator` interface provides methods for validating critical claims
 * within a JWT payload, including issuer (`iss`), audience (`aud`), authorized party (`azp`),
 * timestamps (`exp`, `iat`, `nbf`), and nonce (`nonce`). Implementations of this interface
 * ensure that a JWT meets the necessary security and authenticity requirements.
 */
export interface IClaimsValidator {
  /**
   * Validates the claims in a JWT payload.
   *
   * This method performs a series of checks on the JWT payload to ensure that:
   * - The issuer (`iss`) matches the expected issuer.
   * - The audience (`aud`) includes the expected audience.
   * - The authorized party (`azp`) is valid when multiple audiences are present.
   * - The timestamps (`exp`, `iat`, `nbf`) are within acceptable ranges.
   * - The nonce (`nonce`) matches the expected value, if provided.
   *
   * @param {JwtPayload} payload - The JWT payload to validate.
   * @param {string} [nonce] - The expected nonce value, if applicable.
   * @returns {void} Does not return a value but throws an error if validation fails.
   *
   * @throws {ClientError} If any of the validation checks fail.
   *
   * @example
   * ```typescript
   * const claimsValidator: IClaimsValidator = new ClaimsValidator(expectedIssuer, expectedAudience);
   * claimsValidator.validate(jwtPayload, expectedNonce);
   * ```
   */
  validate(payload: JwtPayload, nonce?: string): void;
}
