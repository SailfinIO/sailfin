// src/enums/GrantType.ts

/**
 * Enum representing OAuth 2.0 and OpenID Connect grant types.
 */
export enum GrantType {
  /**
   * Authorization Code Grant Type
   * Used with server-side Applications.
   */
  AuthorizationCode = 'authorization_code',

  /**
   * Implicit Grant Type
   * Used with mobile apps or web applications (applications that run on the user's device).
   * Note: Implicit flow is deprecated in OAuth 2.1.
   */
  Implicit = 'implicit',

  /**
   * Resource Owner Password Credentials Grant Type
   * Not recommended except for legacy applications.
   */
  Password = 'password',

  /**
   * Client Credentials Grant Type
   * Used for machine-to-machine authentication.
   */
  ClientCredentials = 'client_credentials',

  /**
   * Refresh Token Grant Type
   * Used to obtain a new access token when the current one expires.
   */
  RefreshToken = 'refresh_token',

  /**
   * Device Code Grant Type
   * Used for devices that do not have an easy input method (e.g., smart TVs).
   */
  DeviceCode = 'urn:ietf:params:oauth:grant-type:device_code',

  /**
   * Hybrid Flow
   * Combines authorization code and implicit flows.
   */
  Hybrid = 'hybrid',

  /**
   * JWT Bearer Token Grant Type
   * Used for exchanging a JWT for an access token.
   */
  JWTBearer = 'urn:ietf:params:oauth:grant-type:jwt-bearer',

  /**
   * SAML 2.0 Bearer Assertion Grant Type
   * Used for exchanging a SAML assertion for an access token.
   */
  SAML2Bearer = 'urn:ietf:params:oauth:grant-type:saml2-bearer',

  /**
   * Custom or Unsupported Grant Type
   * Allows for flexibility in case of non-standard grant types.
   */
  Custom = 'custom',
}
