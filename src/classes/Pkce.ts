/**
 * @fileoverview
 * Service class for generating Proof Key for Code Exchange (PKCE) code verifiers and code challenges.
 * This class provides methods to generate PKCE parameters based on the specified configuration.
 *
 * @module src/classes/Pkce
 */

import { createHash, randomBytes } from 'crypto';
import { PkceMethod, BinaryToTextEncoding } from '../enums';
import { ClientError } from '../errors/ClientError';
import { IClientConfig, IPkce } from '../interfaces';

/**
 * Service for generating PKCE code verifiers and code challenges.
 *
 * The `Pkce` class encapsulates the logic for creating PKCE parameters,
 * which are used in OAuth 2.0 and OpenID Connect flows to enhance security.
 * It supports both the `plain` and `S256` methods for generating code challenges.
 *
 * @example
 * ```typescript
 * const config: IClientConfig = { /* ... *\/ };
 * const pkceService = new Pkce(config);
 * const { codeVerifier, codeChallenge } = pkceService.generatePkce();
 * ```
 */
export class Pkce implements IPkce {
  private readonly codeVerifierLength = 32;

  /**
   * Initializes a new instance of the `Pkce` class.
   *
   * @param {IClientConfig} config - The client configuration object.
   * @readonly config - The client configuration object.
   * @throws {ClientError} If `pkce` is enabled but `pkceMethod` is not specified or invalid.
   */
  constructor(private readonly config: IClientConfig) {
    if (this.config.pkce) {
      if (
        !this.config.pkceMethod ||
        !Object.values(PkceMethod).includes(this.config.pkceMethod)
      ) {
        throw new ClientError(
          'Invalid PKCE configuration: `pkceMethod` must be specified and valid when PKCE is enabled.',
          'INVALID_PKCE_CONFIG',
        );
      }
    }
  }

  /**
   * Generates PKCE code verifier and code challenge.
   *
   * @returns {{ codeVerifier: string; codeChallenge: string }} An object containing the code verifier and code challenge.
   * @throws {ClientError} If PKCE is enabled and code challenge generation fails.
   *
   * @example
   * ```typescript
   * const { codeVerifier, codeChallenge } = pkceService.generatePkce();
   * ```
   */
  public generatePkce(): { codeVerifier: string; codeChallenge: string } {
    const codeVerifier = this.generateCodeVerifier();
    const codeChallenge = this.generateCodeChallenge(codeVerifier);
    return { codeVerifier, codeChallenge };
  }

  /**
   * Generates a secure random code verifier.
   *
   * @returns {string} A base64url-encoded string serving as the code verifier.
   */
  private generateCodeVerifier(): string {
    return randomBytes(this.codeVerifierLength).toString(
      BinaryToTextEncoding.BASE_64_URL,
    );
  }

  /**
   * Generates a code challenge based on the code verifier and PKCE method.
   *
   * @param {string} verifier - The code verifier.
   * @returns {string} The generated code challenge.
   * @throws {ClientError} If an unsupported PKCE method is specified.
   */
  private generateCodeChallenge(verifier: string): string {
    if (!this.config.pkce || this.config.pkceMethod === PkceMethod.Plain) {
      return verifier;
    }

    if (this.config.pkceMethod === PkceMethod.S256) {
      return createHash('sha256')
        .update(verifier)
        .digest(BinaryToTextEncoding.BASE_64_URL);
    }

    throw new ClientError(
      `Unsupported PKCE method: ${this.config.pkceMethod}`,
      'UNSUPPORTED_PKCE_METHOD',
    );
  }
}
