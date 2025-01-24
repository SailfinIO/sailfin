// src/enums/TokenTypeHint.ts

/**
 * Enum representing the type of token hint to use for token revocation.
 *
 * @enum {TokenTypeHint}
 * @readonly
 * @since 0.0.15
 */
export enum TokenTypeHint {
  /**
   * Access Token Hint
   */
  AccessToken = 'access_token',

  /**
   * Refresh Token Hint
   */
  RefreshToken = 'refresh_token',

  /**
   * ID Token Hint
   */
  IdToken = 'id_token',
}
