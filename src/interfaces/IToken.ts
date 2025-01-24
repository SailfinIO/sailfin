// src/interfaces/IToken.ts

import { TokenSet } from './TokenSet';
import { ITokenIntrospectionResponse } from './ITokenIntrospectionResponse';
import { TokenTypeHint } from '../enums/TokenTypeHint';
import { ClaimsRecord } from '../types';

export interface IToken {
  /**
   * Sets the tokens based on the token response.
   * @param tokenResponse The response containing tokens.
   */
  setTokens(tokenResponse: TokenSet): void;

  /**
   * Retrieves the current access token, refreshing it if necessary.
   * @returns A promise that resolves to the access token or null.
   */
  getAccessToken(): Promise<string | null>;

  /**
   * Refreshes the access token using the refresh token.
   */
  refreshAccessToken(): Promise<void>;

  /**
   * Retrieves the current token response.
   * @returns The token response or null if no tokens are set.
   */
  getTokens(): TokenSet | null;

  /**
   * Clears all stored tokens.
   */
  clearTokens(): void;

  /**
   * Introspects a given token.
   * @param token The token to introspect.
   * @returns A promise that resolves to the introspection response.
   */
  introspectToken(token: string): Promise<ITokenIntrospectionResponse>;

  /**
   * Revokes a given token.
   * @param token The token to revoke.
   * @param tokenTypeHint Optional hint about the type of token.
   */
  revokeToken(token: string, tokenTypeHint?: TokenTypeHint): Promise<void>;

  /**
   * Exchanges an authorization code for tokens.
   *
   * This method sends a request to the token endpoint to exchange the provided
   * authorization code for access and ID tokens. It supports PKCE and various
   * grant types, including Resource Owner Password Credentials.
   *
   * @param {string} code - The authorization code received from the authorization server.
   * @param {string} [codeVerifier] - Optional code verifier if PKCE is used.
   * @param {string} [username] - Optional username for Resource Owner Password Credentials grant.
   * @param {string} [password] - Optional password for Resource Owner Password Credentials grant.
   * @returns {Promise<void>} Resolves when tokens are successfully obtained and stored.
   *
   * @throws {ClientError} If the token exchange fails or required parameters are missing.
   *
   * @example
   * ```typescript
   * await authClient.exchangeCodeForToken(authCode, codeVerifier);
   * ```
   */
  exchangeCodeForToken(
    code: string,
    codeVerifier?: string,
    username?: string,
    password?: string,
  ): Promise<void>;

  /**
   * Retrieves claims from the access token.
   * @returns A promise that resolves to an array of claim keys.
   */
  getClaims(): Promise<ClaimsRecord>;
}
