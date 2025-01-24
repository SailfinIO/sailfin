/**
 * @fileoverview
 * Defines the `ClaimsValidator` class, responsible for validating claims in a JWT payload.
 * This class ensures that critical claims such as `iss`, `aud`, `exp`, and `nonce` conform to expected values.
 *
 * @module src/classes/ClaimsValidator
 */

import { ClientError } from '../errors/ClientError';
import { JwtPayload, IClaimsValidator } from '../interfaces';

/**
 * Validates claims in a JWT payload.
 *
 * The `ClaimsValidator` class provides methods for validating critical claims in a JWT payload,
 * including issuer, audience, timestamps, and nonce. It is designed to ensure that an ID token
 * meets the expected requirements for security and authenticity.
 *
 * @class ClaimsValidator
 */
export class ClaimsValidator implements IClaimsValidator {
  /**
   * The expected issuer of the JWT.
   *
   * @readonly
   * @type {string}
   */
  private readonly expectedIssuer: string;

  /**
   * The expected audience of the JWT.
   *
   * @readonly
   * @type {string}
   */
  private readonly expectedAudience: string;

  /**
   * The maximum allowable future time in seconds for the `iat` claim.
   *
   * @readonly
   * @type {number}
   */
  private readonly maxFutureSec: number;

  /**
   * Creates an instance of `ClaimsValidator`.
   *
   * @param {string} expectedIssuer - The expected issuer (`iss`) of the JWT.
   * @param {string} expectedAudience - The expected audience (`aud`) of the JWT.
   * @param {number} [maxFutureSec=300] - Maximum allowable future time for `iat` claim, in seconds.
   */
  constructor(
    expectedIssuer: string,
    expectedAudience: string,
    maxFutureSec = 300,
  ) {
    this.expectedIssuer = expectedIssuer;
    this.expectedAudience = expectedAudience;
    this.maxFutureSec = maxFutureSec;
  }

  /**
   * Validates the claims in a JWT payload.
   *
   * This method checks:
   * - The `iss` (issuer) claim matches the expected issuer.
   * - The `aud` (audience) claim contains the expected audience.
   * - The `azp` (authorized party) claim is valid for multiple audiences.
   * - The `exp`, `iat`, and `nbf` claims are within acceptable time constraints.
   * - The `nonce` claim matches the expected value, if provided.
   *
   * @param {JwtPayload} payload - The JWT payload to validate.
   * @param {string} [nonce] - The expected nonce, if applicable.
   * @throws {ClientError} If any validation fails.
   */
  public validate(payload: JwtPayload, nonce?: string): void {
    this.validateIssuer(payload.iss);
    this.validateAudience(payload.aud);
    this.validateAzp(payload);
    this.validateTimestamps(payload);
    this.validateNonce(payload, nonce);
  }

  /**
   * Validates the `iss` (issuer) claim.
   *
   * @param {string | undefined} iss - The `iss` claim to validate.
   * @throws {ClientError} If the `iss` claim does not match the expected issuer.
   */
  private validateIssuer(iss?: string): void {
    if (iss !== this.expectedIssuer) {
      throw new ClientError(
        `Invalid issuer: ${iss}`,
        'ID_TOKEN_VALIDATION_ERROR',
      );
    }
  }

  /**
   * Validates the `aud` (audience) claim.
   *
   * @param {string | string[] | undefined} aud - The `aud` claim to validate.
   * @throws {ClientError} If the `aud` claim does not include the expected audience.
   */
  private validateAudience(aud: string | string[] | undefined): void {
    const audArray = Array.isArray(aud) ? aud : [aud];
    if (!audArray.includes(this.expectedAudience)) {
      throw new ClientError(
        'Audience not found in ID token',
        'ID_TOKEN_VALIDATION_ERROR',
      );
    }
  }

  /**
   * Validates the `azp` (authorized party) claim for multiple audiences.
   *
   * @param {JwtPayload} payload - The JWT payload containing the `azp` claim.
   * @throws {ClientError} If the `azp` claim is invalid for multiple audiences.
   */
  private validateAzp(payload: JwtPayload): void {
    const audArray = Array.isArray(payload.aud) ? payload.aud : [payload.aud];
    if (
      audArray.length > 1 &&
      payload.azp &&
      payload.azp !== this.expectedAudience
    ) {
      throw new ClientError(
        'Invalid authorized party (azp) in ID token',
        'ID_TOKEN_VALIDATION_ERROR',
      );
    }
  }

  /**
   * Validates the `exp`, `iat`, and `nbf` claims for expiration, issued-at, and not-before times.
   *

   * @param {JwtPayload} payload - The JWT payload to validate.
   * @throws {ClientError} If any of the timestamp claims are invalid.
   */
  private validateTimestamps(payload: JwtPayload): void {
    const now = Math.floor(Date.now() / 1000);
    if (payload.exp && payload.exp < now) {
      throw new ClientError('ID token is expired', 'ID_TOKEN_VALIDATION_ERROR');
    }
    if (payload.iat && payload.iat > now + this.maxFutureSec) {
      throw new ClientError(
        'ID token iat is too far in the future',
        'ID_TOKEN_VALIDATION_ERROR',
      );
    }
    if (payload.nbf && payload.nbf > now) {
      throw new ClientError(
        'ID token not valid yet (nbf)',
        'ID_TOKEN_VALIDATION_ERROR',
      );
    }
  }

  /**
   * Validates the `nonce` claim.
   *
   * @param {JwtPayload} payload - The JWT payload containing the `nonce` claim.
   * @param {string | undefined} nonce - The expected nonce value.
   * @throws {ClientError} If the `nonce` claim does not match the expected value.
   */
  private validateNonce(payload: JwtPayload, nonce?: string): void {
    if (nonce && payload.nonce !== nonce) {
      throw new ClientError(
        'Invalid nonce in ID token',
        'ID_TOKEN_VALIDATION_ERROR',
      );
    }
  }
}
