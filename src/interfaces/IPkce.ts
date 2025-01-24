/**
 * @fileoverview
 * Interface for generating Proof Key for Code Exchange (PKCE) code verifiers and code challenges.
 * This interface provides a contract for implementing PKCE-related logic in OAuth 2.0 and OIDC flows.
 *
 * @module src/interfaces/IPkce
 */

/**
 * Represents the response from generating PKCE parameters.
 *
 * @interface IPkceResponse
 */
export interface IPkceResponse {
  /**
   * A secure, random string serving as the code verifier.
   */
  codeVerifier: string;

  /**
   * The derived code challenge based on the code verifier.
   */
  codeChallenge: string;
}

/**
 * Interface for managing PKCE logic.
 *
 * The `IPkce` interface defines methods for generating PKCE parameters,
 * including secure code verifiers and their corresponding code challenges.
 * Implementations of this interface must ensure support for both `plain`
 * and `S256` PKCE methods as defined in the OAuth 2.0 PKCE specification.
 */
export interface IPkce {
  /**
   * Generates PKCE code verifier and code challenge.
   *
   * This method creates a secure random code verifier and derives the
   * corresponding code challenge based on the configured PKCE method.
   *
   * @returns {IPkceResponse} An object containing the code verifier and code challenge.
   * @throws {Error} If PKCE configuration is invalid or code challenge generation fails.
   *
   * @example
   * ```typescript
   * const pkceResponse = pkceService.generatePkce();
   * console.log(pkceResponse.codeVerifier, pkceResponse.codeChallenge);
   * ```
   */
  generatePkce(): IPkceResponse;
}
